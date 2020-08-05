const { webkit } = require('playwright');

test('two plus two is four', () => {
  (async () => {
    const browser = await webkit.launch();
    const page = await browser.newPage();
    await page.goto('http://localhost:3000/');
    await page.screenshot({ path: `example.png` });
    await browser.close();
  })();

  expect(2 + 2).toBe(4);
});
