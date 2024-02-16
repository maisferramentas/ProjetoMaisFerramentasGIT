<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Arrastar Divs</title>
    <style>
      .container {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
      }

      .draggable {
        border: 1px solid #ccc;
        margin-bottom: 10px;
        padding: 10px;
        cursor: pointer;
      }

      .dragging {
        opacity: 0.5;
      }
    </style>
  </head>
  <body>
    <div class="container" id="container">
      <div class="draggable" draggable="true" id="1">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <label for="">Elemento A</label>
        <input type="text" />
      </div>
      <div class="draggable" draggable="true" id="2">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <label for="">Elemento B</label>
        <input type="text" />
      </div>
      <div class="draggable" draggable="true" id="3">
        <span class="material-symbols-outlined drag_indicator">
          drag_indicator
        </span>
        <label for="">Elemento C</label>
        <input type="text" />
      </div>
    </div>

    <script>
      const draggables = document.querySelectorAll(".draggable");
      let dragStartIndex;

      draggables.forEach((draggable) => {
        draggable.addEventListener("dragstart", () => {
          draggable.classList.add("dragging");
          dragStartIndex = +draggable.id;
        });

        draggable.addEventListener("dragend", () => {
          draggable.classList.remove("dragging");
          updateIds();
        });
      });

      function updateIds() {
        const draggables = document.querySelectorAll(".draggable");
        draggables.forEach((draggable, index) => {
          draggable.id = index + 1;
        });
      }

      const container = document.getElementById("container");

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

      function getDragAfterElement(container, y) {
        const draggableElements = [
          ...container.querySelectorAll(".draggable:not(.dragging)"),
        ];
        return draggableElements.reduce(
          (closest, child) => {
            const box = child.getBoundingClientRect();
            const offset = y - box.top - box.height / 2;
            if (offset < 0 && offset > closest.offset) {
              return { offset: offset, element: child };
            } else {
              return closest;
            }
          },
          { offset: Number.NEGATIVE_INFINITY }
        ).element;
      }
    </script>
  </body>
</html>
