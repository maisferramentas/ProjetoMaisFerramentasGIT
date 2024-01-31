<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>;
function alerta(titulo, texto, icone) {
  // titulo = "Adicionar à Lista";
  // texto = "Novo registro salvo com sucesso!";
  // icone = "success";

  Swal.fire({
    title: titulo,
    text: texto,
    icon: icone,
    confirmButtonText: "Ok!",
  });
}
