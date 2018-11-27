const cartButton = document.querySelector('.icon-cart');
console.log(cartButton);

function toggleIcon() {
  cartButton.addEventListener("click", (event) => {
    cartButton.classList.toggle("added");
  });
}

toggleIcon();
