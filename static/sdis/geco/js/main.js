document.addEventListener("DOMContentLoaded", () => {
  const navbar = document.querySelector(".datalogo-navbar");
  const compactAt = 72;
  const expandAt = 18;

  const updateNavbarState = () => {
    if (!navbar) return;
    const isCompact = navbar.classList.contains("is-compact");

    if (!isCompact && window.scrollY > compactAt) {
      navbar.classList.add("is-compact");
      document.body.classList.add("nav-is-compact");
    }

    if (isCompact && window.scrollY < expandAt) {
      navbar.classList.remove("is-compact");
      document.body.classList.remove("nav-is-compact");
    }

    if (window.scrollY <= compactAt && window.scrollY >= expandAt) {
      document.body.classList.toggle("nav-is-compact", navbar.classList.contains("is-compact"));
    }
  };

  document.querySelectorAll("img.lazyload[data-src]").forEach((image) => {
    if (!image.getAttribute("src")) {
      image.setAttribute("src", image.dataset.src);
    }
  });

  const repository = document.querySelector("[data-ecosistema-repository]");
  if (repository) {
    fetch("data/ecosistema-documentos.json")
      .then((response) => {
        if (!response.ok) {
          throw new Error("No se pudo cargar el repositorio.");
        }
        return response.json();
      })
      .then((documents) => {
        repository.innerHTML = "";
        documents.forEach((documentItem) => {
          const row = document.createElement("article");
          row.className = "knowledge-row";

          const thumb = document.createElement("a");
          thumb.className = "knowledge-thumb";
          thumb.href = encodeURI(documentItem.pdfPath);
          thumb.target = "_blank";
          thumb.rel = "noopener";

          const image = document.createElement("img");
          image.src = encodeURI(documentItem.thumbPath);
          image.alt = `Miniatura de ${documentItem.title}`;
          thumb.appendChild(image);

          const content = document.createElement("div");
          content.className = "knowledge-content";

          if (documentItem.category) {
            const tag = document.createElement("span");
            tag.className = "tag-differential";
            tag.textContent = documentItem.category;
            content.appendChild(tag);
          }

          const title = document.createElement("h3");
          const titleLink = document.createElement("a");
          titleLink.href = encodeURI(documentItem.pdfPath);
          titleLink.target = "_blank";
          titleLink.rel = "noopener";
          titleLink.textContent = documentItem.title;
          title.appendChild(titleLink);
          content.appendChild(title);

          const meta = document.createElement("div");
          meta.className = "knowledge-meta";
          const author = document.createElement("span");
          const authorLabel = document.createElement("strong");
          authorLabel.textContent = "Autor: ";
          author.append(authorLabel, documentItem.author || "No especificado");
          const year = document.createElement("span");
          const yearLabel = document.createElement("strong");
          yearLabel.textContent = "Año:";
          year.append(yearLabel, document.createTextNode(" "), documentItem.year);
          meta.append(author, year);
          content.appendChild(meta);

          const ideas = document.createElement("p");
          ideas.className = "knowledge-ideas";
          ideas.textContent = documentItem.ideas || "Información pendiente de incorporar.";
          content.appendChild(ideas);

          row.appendChild(thumb);
          row.appendChild(content);
          repository.appendChild(row);
        });
      })
      .catch(() => {
        repository.innerHTML = '<p class="repository-error">No fue posible cargar el repositorio de documentos.</p>';
      });
  }

  updateNavbarState();
  window.addEventListener("scroll", updateNavbarState, { passive: true });
});
