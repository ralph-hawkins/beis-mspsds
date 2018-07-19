// 1. Copy and paste into the Chrome console after searching for the desired products (in Product list view).
// 2. Execute run() command and wait for results
// 3. Results should be downloaded after the execution ended
// Note: If error message displays, it's likely due to an ICSMS fault.
//
// TODO: Capture nested information fields (e.g. "Notifying Authority" in "General")
// TODO: Add more sensible wait condidtions than the magic number wait function
// TODO: Capture product (PI) info. It can be accessed from the dropdown in the product view.

// Load newer jQuery
(function () {
  var script = document.createElement("SCRIPT");
  script.src = 'https://code.jquery.com/jquery-latest.min.js';
  script.type = 'text/javascript';
  script.onload = function () {
    var $ = window.jQuery;
  };
  document.getElementsByTagName("head")[0].appendChild(script);
})();

async function run() {
  const numberOfPages = parseInt($("body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div > div.z-paging > ul > li:nth-child(3) > span").html().replace(/\D/g, ''));
  let prods = []
  console.log(`Number of pages: ${numberOfPages}`)
  for (let i = 1; i < numberOfPages; i++) {
    prods = prods.concat(await getProducts())
    getNextPage()
    await wait(2500)
    console.log(`Navigating to page ${i+1}`)
    console.log(prods)
  }
  downloadObjectAsJson(prods, "incomplete-icsms")
  return prods
}

async function getProducts() {
  const productsInfo = []
  const products = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div > div.z-grid > div.z-grid-body > table > tbody.z-rows > tr > td.z-cell:nth-child(3) > span.z-label`)
  for(let i = 0; i < products.length; i++) {
    console.log(`Reading ${$(products[i]).html()}`)
    product_row = products[i]
    product_row.click()
    await wait()
    const productInfo = await getProductInfo()
    productsInfo.push(productInfo)
    close()
    await wait()
  }
  return productsInfo
}

async function getProductInfo() {
  const productTabs = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div:nth-child(2) > div > div.z-tabbox.z-tabbox-top > div.z-tabs > ul > li.z-tab > a > span`)
  productTabs.each((i, productTab) => {
    productTab.click()
  })
  await wait()

  // this is for loading the nested data.
  nests = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div:nth-child(2) > div > div.z-tabbox.z-tabbox-top.z-tabbox-scroll > div.z-tabpanels > div:nth-child(2) > div > div.z-grid-body > table > tbody.z-rows > tr > td:nth-child(4) > div > div > div > div > div.z-groupbox-header > div > div > i`)
  nests.each((i, nest) => {
    nest.click()
  })
  await wait()

  return getRows()
  
}

function getRows() {
  const rowsData = []
  const rows = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div:nth-child(2) > div > div.z-tabbox.z-tabbox-top > div.z-tabpanels > div > div > div.z-grid-body > table > tbody.z-rows > tr`)
  rows.each((i, row) => {
    rowsData.push(getRowData(i+1, $(row)))
  });

  return rowsData
}

function getRowData(i, row) {
  const code = row.find('.badge-primary')
  const data = row.find('.z-label')
  const rowInfo = {
    code: code.html(),
    title: $(data[0]).html(),
    value: $(data[1]).html()
  }
  return rowInfo
}

function close() {
  const closeButton = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabs > ul > li.z-tab > a > div > i`)
  closeButton[0].click()
}

function getNextPage() {
  const nextPageButton = $(`body > div.z-page > div.main_div.z-div > div.page-container.main.page-content.z-div > div > div > div.z-window-content > div > div.z-tabpanels > div > div.z-paging > ul > li:nth-child(4) > a > i`)
  nextPageButton[0].click()
}

// Magic number wait function. It may be required to increase the 'time' param if the ping is high or DOM creation is slow
function wait(time=300) {
  return new Promise(resolve => {
    setTimeout(resolve, time);
  })
}

function downloadObjectAsJson(exportObj, exportName) {
  var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(exportObj));
  var downloadAnchorNode = document.createElement('a');
  downloadAnchorNode.setAttribute("href", dataStr);
  downloadAnchorNode.setAttribute("download", exportName + ".json");
  document.body.appendChild(downloadAnchorNode); // required for firefox
  downloadAnchorNode.click();
  downloadAnchorNode.remove();
}
