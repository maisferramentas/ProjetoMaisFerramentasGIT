{% extends 'Ferramentas.html' %} {% block content %}
<!DOCTYPE html>
<html lang="en">
  <head>
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />

    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Arrastar e Mudar Posição</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        /* height: 100vh; */
        /* margin: 0; */
      }
      .conteudo {
        font-size: larger;
      }
      .container_column {
        display: flex;
        flex-direction: column;
        /* gap: 10px; */
      }
      .container_row {
        display: flex;
        flex-direction: row;
        /* gap: 10px; */
      }
      .align {
        align-items: center;
      }

      .justify {
        justify-content: center;
      }
      .draggable {
        cursor: grab;
        padding: 10px;
        /* background-color: #f0f0f0; */
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 15px;
        padding-top: 15px;
        padding-bottom: 15px;
        min-width: 350px;
        max-width: 350px;
      }
      .imagem_icone {
        border-radius: 100px 100px 100px 100px;
        width: 40px;
        height: 40px;
        margin-right: 4px;
      }

      .espaco_longo_vertical_elemento_card {
        margin-bottom: 15px;
      }
      .espaco_curto_vertical_elemento_card {
        margin-bottom: 5px;
      }

      .drag_indicator {
        margin-right: 13px;
      }

      .conteudo {
        margin-top: 50px;
      }
      .flex {
        display: flex;
      }

      .entrada_texto {
        width: 100%;
        /* padding: 2px; */
        box-sizing: border-box;
        border: 2px solid #ccc;
        border-radius: 5px;
        font-size: large;
        /* background-color: #fff; */
        /* text-align: center; */
      }
    </style>
  </head>
  <body>
    <div class="conteudo container_column">
      <div id="1" class="draggable container_row align" draggable="true">
        <!-- <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span> -->
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="">Oração:</label>
          <input type="text" name="" id="Oração" class="entrada_texto" />
        </div>
      </div>

      <div id="2" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://www.churchofjesuschrist.org/bc/content/ldsorg/church/news/09/06/580-speaking-in-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for=""> Discursante:</label>
          <input
            type="text"
            name=""
            id="Discursante"
            value=""
            class="espaco_longo_vertical_elemento_card"
          />

          <label for="" class="">Tema:</label>
          <input
            type="text"
            name=""
            id="Tema"
            value=""
            class="espaco_curto_vertical_elemento_card"
          />
          <div class="container_row">
            <label for="" class="espaco_curto_vertical_elemento_card"
              >Até às:</label
            >
            <input
              type="time"
              id="Até"
              class="espaco_curto_vertical_elemento_card"
            />
            <label for="" class="espaco_curto_vertical_elemento_card"
              >Hrs</label
            >
          </div>
          <div class="container_row">
            <label for="">Duração:</label>
            <input type="time" name="a" id="Duração" value="" />
            <label for="">minutos</label>
          </div>
        </div>
        <!-- <textarea
          name="a"
          id="campo"
          rows="2"
          value=""
          style="font-family: Arial, sans-serif; font-weight: bold"
        ></textarea> -->
      </div>

      <div id="3" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://newsroom.churchofjesuschrist.org/media/orig/girl-spanish-hymnbook-resized.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="">Hino:</label>
          <input type="text" id="Hino" name="" value="" />

          <label for="">Apresentado por:</label>
          <input type="text" id="Apresentado_por" name="" value="" />
        </div>
      </div>

      <div id="4" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://www.churchofjesuschrist.org/bc/content/ldsorg/church/news/09/06/580-speaking-in-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column justify">
          <label for="">Anúncio:</label>
          <input
            type="text"
            name=""
            id="Anúncio"
            class="espaco_longo_vertical_elemento_card"
          />

          <label for="">Para:</label>
          <input
            type="text"
            name=""
            id="Para"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Local:</label>
          <input
            type="text"
            name=""
            id="Local"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Data:</label>
          <input
            type="date"
            name=""
            id="Data"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Horário:</label>
          <input
            type="time"
            id="Horário"
            required
            class="espaco_curto_vertical_elemento_card"
          />
        </div>
      </div>

      <div id="5" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="">Confirmação:</label>
          <input type="text" name="" id="Confirmação" />
        </div>
      </div>

      <div id="6" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="">Apresentação de membros novos:</label>
          <input type="text" name="" id="Membros_novos" />
        </div>
      </div>

      <div id="7" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="" class="espaco_longo_vertical_elemento_card"
            >Apoio para Ordenação ao Sacerdócio</label
          >
          <label for="">Nome:</label>
          <input
            type="text"
            name=""
            id="Ordenação_Nome"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Oficio:</label>
          <input type="text" name="" id="Oficio" />
        </div>
      </div>

      <div id="8" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="" class="espaco_longo_vertical_elemento_card"
            >Apoio para Chamado</label
          >

          <label for="">Nome:</label>
          <input
            type="text"
            name=""
            id="Apoio_Nome"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Chamado:</label>
          <input type="text" name="" id="Chamado" />
        </div>
      </div>

      <div id="9" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="container_column">
          <label for="" class="espaco_longo_vertical_elemento_card"
            >Desobrigação</label
          >
          <label for="">Nome:</label>
          <input
            type="text"
            name=""
            id="Desobrigação_Nome"
            class="espaco_curto_vertical_elemento_card"
          />

          <label for="">Chamado:</label>
          <input type="text" name="" id="Chamado" />
        </div>
      </div>

      <div id="10" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <label for="">Preside:</label>
        <input type="text" name="" id="Preside" />
      </div>

      <div id="11" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <label for="">Dirige:</label>
        <input type="text" name="" id="Dirige" />
      </div>

      <div id="12" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <label for="">Organista:</label>
        <input type="text" name="" id="Organista" />
      </div>

      <div id="13" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <label for="">Regente:</label>
        <input type="text" name="" id="Regente" />
      </div>

      <div id="14" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <div class="flex">
          <label for="">Reconhecimento:</label>
          <input type="text" name="" id="Reconhecimento" />
        </div>
      </div>

      <div id="15" class="draggable container_row align" draggable="true">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <!-- <img
          src="https://content.churchofjesuschrist.org/acp/bc/cp/Canada/images2020/Does%20God%20Really%20Want%20to%20Speak%20to%20You%20Yes/1-banner-prayer-church.jpg"
          alt=""
          class="imagem_icone"
        /> -->
        <label for="">Testemunho:</label>
        <input type="text" name="" id="Testemunho" />
      </div>

      <input type="button" value="Aqui" onclick="capturarValores()" />
    </div>
  </body>
    <script>
      const draggableElements = document.querySelectorAll(".draggable");

      draggableElements.forEach((element) => {
        element.addEventListener("dragstart", dragStart);
        element.addEventListener("dragover", dragOver);
        element.addEventListener("drop", dragDrop);
      });

      function dragStart(event) {
        event.dataTransfer.setData("text/plain", event.target.id);
      }

      function dragOver(event) {
        event.preventDefault();
      }

      function dragDrop(event) {
        const idDragged = event.dataTransfer.getData("text");
        const idDropped = event.target.id;

        const elementDragged = document.getElementById(idDragged);
        const elementDropped = document.getElementById(idDropped);

        // Verifica se o elementoDropped é nulo ou se não é uma div arrastável
        if (
          !elementDropped ||
          !elementDropped.classList.contains("draggable")
        ) {
          return; // Sai da função se não for possível soltar em um elemento droppable
        }
        const container_column = elementDropped.parentNode;

        // Obtém a posição do elemento sendo solto
        const indexDragged = Array.from(container_column.children).indexOf(
          elementDragged
        );
        // Obtém a posição do elemento sobre o qual o elemento está sendo solto
        const indexDropped = Array.from(container_column.children).indexOf(
          elementDropped
        );

        // Insere o elemento sendo arrastado na posição correta
        if (indexDragged < indexDropped) {
          container_column.insertBefore(
            elementDragged,
            elementDropped.nextSibling
          );
        } else {
          container_column.insertBefore(elementDragged, elementDropped);
        }

        // Atualizar IDs
        const allDraggables = document.querySelectorAll(".draggable");
        allDraggables.forEach((element, index) => {
          element.id = index + 1;
        });

        id_proxima_div =
          parseInt(allDraggables[allDraggables.length - 1].id) + 1;
      }

      // Função para capturar os valores de todos os tipos de inputs dentro de cada div e transformá-los em strings formatadas
      function capturarValores() {
        // Seleciona todas as divs com a classe 'draggable'
        const allDraggables = document.querySelectorAll(".draggable");

        // Objeto para armazenar as strings formatadas
        const stringsFormatadas = {};

        // Itera sobre cada div
        allDraggables.forEach((div) => {
          // Obtém o ID da div atual
          const divId = div.id;

          // Seleciona todos os inputs dentro da div atual
          const inputs = div.querySelectorAll(
            'input[type="text"], input[type="hidden"], input[type="date"], input[type="time"], select'
          );

          // Array para armazenar os valores dos inputs da div atual
          const valoresInputs = [];

          // Itera sobre cada input dentro da div atual
          inputs.forEach((input) => {
            // Obtém o ID do input
            const inputId = input.id;

            // Adiciona o valor do input com ou sem o ID como prefixo, dependendo se o ID está vazio ou não
            const valor = `${inputId}: ${input.value}`;
            valoresInputs.push(valor);
          });

          // Verifica se há algum valor na div
          if (valoresInputs.length > 0) {
            // Se houver valores, adiciona ao objeto de strings formatadas
            // Verifica se há mais de um valor
            if (valoresInputs.length > 1) {
              // Se houver mais de um valor, os valores são unidos com pipe
              stringsFormatadas[`${divId}`] = valoresInputs.join(" | ");
            } else {
              // Se houver apenas um valor, não há pipes
              stringsFormatadas[`${divId}`] = valoresInputs[0];
            }
          }
        });

        // Retorna o objeto com as strings formatadas
        console.log(stringsFormatadas);
        return stringsFormatadas;
      }
    </script>
  
</html>
{% endblock %}
