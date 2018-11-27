let value;
const quantity = document.getElementsByClassName('quantity');
const table = document.querySelector(".order-list-summary");
const total = document.querySelector(".total");

function createBindings(quantityContainer) {
  let quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
  let increase = quantityContainer.getElementsByClassName('increase')[0];
  let decrease = quantityContainer.getElementsByClassName('decrease')[0];
  increase.addEventListener('click', function () { increaseValue(quantityAmount); });
  decrease.addEventListener('click', function () { decreaseValue(quantityAmount); });
  const index = quantityContainer.parentNode.classList[1];
  console.log(quantityAmount.value);
  table.querySelector(`.${index}`).innerText = parseInt(quantityAmount.value, 10);
}
function increaseValue(quantityAmount) {
    value = parseInt(quantityAmount.value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    total.innerText ++;
    quantityAmount.value = value;
    const index = quantityAmount.parentNode.parentNode.classList[1];
    table.querySelector(`.${index}`).innerText = value;
}
function decreaseValue(quantityAmount) {
    value = parseInt(quantityAmount.value, 10);
    value = isNaN(value) ? 0 : value;
    if (value > 0) {
      value--;
      total.innerText --;
    }
    quantityAmount.value = value;
    const index = quantityAmount.parentNode.parentNode.classList[1];
    table.querySelector(`.${index}`).innerText = value;
}

const applyToTable = () => {

}

function init() {
    for (let i = 0; i < quantity.length; i++ ) {
      createBindings(quantity[i]);
    }
    total.innerText += quantity.length;
};
export default init;
