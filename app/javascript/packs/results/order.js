let value,
quantity = document.getElementsByClassName('quantity');

function createBindings(quantityContainer) {
  let quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
  let increase = quantityContainer.getElementsByClassName('increase')[0];
  let decrease = quantityContainer.getElementsByClassName('decrease')[0];
  increase.addEventListener('click', function () { increaseValue(quantityAmount); });
  decrease.addEventListener('click', function () { decreaseValue(quantityAmount); });
}
function init() {
    for (let i = 0; i < quantity.length; i++ ) {
      createBindings(quantity[i]);
    }
};
function increaseValue(quantityAmount) {
    value = parseInt(quantityAmount.value, 10);

    // console.log(quantityAmount, quantityAmount.value);

    value = isNaN(value) ? 0 : value;
    value++;
    quantityAmount.value = value;
}
function decreaseValue(quantityAmount) {
    value = parseInt(quantityAmount.value, 10);

    value = isNaN(value) ? 0 : value;
    if (value > 0) value--;

    quantityAmount.value = value;
}
init();
