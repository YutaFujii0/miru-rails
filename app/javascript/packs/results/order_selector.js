

function selectItem() {
  const cards = document.querySelectorAll(".card-order-list img");
    console.log(cards);
  cards.forEach((card) => {
    card.addEventListener("click", (event) => {
      const targetCard = event.target.parentNode;
      console.log(targetCard);
      cards.forEach((card) => {
        card.parentNode.classList.remove("active");
      });
      targetCard.classList.add("active");
    });
  });
}

export default selectItem;
