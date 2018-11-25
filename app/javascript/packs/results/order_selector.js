const cards = document.querySelectorAll(".card-order-list img");

const changeActiveSelector = (event) => {
  const targetCard = event.target.parentNode;
  cards.forEach((card) => {
    card.parentNode.classList.remove("active");
  });
  targetCard.classList.add("active");
}

function selectItem() {
  cards.forEach((card) => {
    card.addEventListener("click", changeActiveSelector);
  });
}

export default selectItem;
