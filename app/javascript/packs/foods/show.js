// changing color of icon

const cartButton = document.querySelector('.icon-cart');

function toggleIcon() {
  cartButton.addEventListener("click", (event) => {
    cartButton.classList.toggle("added");
  });
}

if (cartButton) {
  toggleIcon();
}

// changing banner picture
const extraImages = document.querySelector('.foods-extra');
const coverImage = document.querySelector('.food-pic img');

function changeCoverImage() {
  extraImages.addEventListener("click", (event) => {
    coverImage.src = event.target.src;
  });
}

changeCoverImage();
