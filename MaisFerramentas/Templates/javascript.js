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
    if (!elementDropped || !elementDropped.classList.contains("draggable")) {
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
      container_column.insertBefore(elementDragged, elementDropped.nextSibling);
    } else {
      container_column.insertBefore(elementDragged, elementDropped);
    }

    // Atualizar IDs
    const allDraggables = document.querySelectorAll(".draggable");
    allDraggables.forEach((element, index) => {
      element.id = index + 1;
    });

    id_proxima_div = parseInt(allDraggables[allDraggables.length - 1].id) + 1;
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


acrescente o código a seguir adaptando-o para criar a previsuzlização

container.addEventListener("dragover", (e) => {
  e.preventDefault();
  const afterElement = getDragAfterElement(container, e.clientY);
  const draggable = document.querySelector(".dragging");
  if (afterElement == null) {
    container.appendChild(draggable);
  } else {
    container.insertBefore(draggable, afterElement);
  }
});
