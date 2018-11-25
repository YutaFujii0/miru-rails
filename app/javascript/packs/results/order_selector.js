const images = document.querySelectorAll(".card-order-list img");
const bodyContents = document.querySelectorAll(".card-result-body");

const changeActiveSelector = (event) => {
  const targetCard = event.target.parentNode;
  images.forEach((image) => {
    image.parentNode.classList.remove("active");
  });
  targetCard.classList.add("active");
}

const changeBodyContent = (event) => {
  const index = event.target.classList[1];
  console.log(`.card-result-body .${index}`);
  const targetBodyContent = document.querySelector(`.card-result-body.${index}`);
  console.log(targetBodyContent);
  bodyContents.forEach((content) => {
    content.classList.add("hidden");
  })
  targetBodyContent.classList.remove("hidden");
}

function selectItem() {
  images.forEach((image) => {
    image.addEventListener("click", (event) => {
      changeActiveSelector(event);
      changeBodyContent(event);
    });
  });
}

export default selectItem;
