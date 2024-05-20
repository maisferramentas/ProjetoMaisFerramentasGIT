const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto('http://127.0.0.1:8000/template_JOB_notifica_aniversariantes_email', {
        waitUntil: 'networkidle2'
    });

    // Se você precisar esperar por uma requisição AJAX específica, pode usar page.waitForSelector()
    await page.waitForSelector('#ancora_aniversariantes'); // Substitua .some-element pelo seletor que você espera aparecer após a execução do AJAX

    const content = await page.content(); // Captura o conteúdo da página após o carregamento
    // console.log(content); // Exibe o conteúdo capturado

    await browser.close();
})();
