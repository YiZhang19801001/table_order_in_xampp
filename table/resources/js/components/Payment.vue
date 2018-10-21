<template>
    <div class="payment">
        <!-- order section -->
        <h6>Your Order: </h6>
        <div>
            <!-- list of order_items -->
            <ul>
                <li v-for="(orderItem,index) in orderList" :key="index">
                        <div class="orderItem-img">
                            <img src="https://via.placeholder.com/60" alt="">
                        </div>
                        <div class="orderItem-info-container">
                            <div class="orderItem-name-quantity">
                                <div class="orderItem-name">
                                    <h5>{{orderItem.item.name}}</h5>
                                </div>
                                <div class="orderItem-quantity">
                                    <p> X {{orderItem.quantity}}</p>
                                </div>
                            </div>
                            <div class="orderItem-choice-price">
                                <ul class="choice-list">
                                    <li v-for="(choice,index2) in orderItem.item.choices" :key="index2">
                                        {{choice.type}} {{choice.pickedChoice}}
                                    </li>
                                </ul>
                                <div class="orderItem-price">
                                    <p>${{orderItem.item.price}}</p>
                                </div>
                            </div>
                        </div>
                    <!-- list of choice for each order_item -->

                </li>
            </ul>
        </div>
        <!-- order section end -->

        <!-- payment method section -->
        <div class="payment-method">
            <h6>payment method</h6>
            <div class="icon-group">
                <div class="payment-choice"><img src="https://via.placeholder.com/40" alt=""><p>Credit</p></div>
                <div class="payment-choice"><img src="https://via.placeholder.com/40" alt=""><p>Paypal</p></div>
                <div class="payment-choice"><img src="https://via.placeholder.com/40" alt=""><p>Cash</p></div>
            </div>
        </div>
        <!-- payment methdo seciton end -->

        <!-- payment detail section -->
        <h6>pament detail</h6>
        <div class="payment-detail-container">
            <div>
                <span>cost</span>
                <span class="number">{{totalPriceOfOrder}}</span>
            </div>
            <div>
                <span>GST</span>
                <span class="number">0.00</span>
            </div>
            <div>
                <span>Total (incl. GST)</span>
                <span class="number"> ${{totalPriceOfOrder}}</span>
            </div>
        </div>
        <!-- payment detail section end -->
        <!-- payment footer -->
        <div class="footer">
            <div class="footer-content-container">
                <div class="footer-title"><h2>Total:</h2></div>
                <div class="footer-detail">
                    <div class="footer-detail-info"><span>table: {{table_number}}</span><span>order: {{orderId}}</span></div>
                    <div class="footer-detail-total">
                        <span> ${{totalPriceOfOrder}}</span>
                    </div>
                </div>
                <div class="footer-button"> 
                    <div class="animated infinite pulse">
                        <i class="material-icons">attach_money</i>
                    </div>
                </div>
            </div>
        </div>
        <!-- payment footer end -->
    </div>
</template>


<script>
import { mapState, mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["orderId", "orderList", "totalPriceOfOrder", "table_number"])
  }
};
</script>


<style lang="scss" scoped>
.payment {
  h6 {
    padding: 10px;
    font-weight: bold;
    color: #9b9b9b;
    border-bottom: 1px solid #e9e6e6;
    font-size: 16px;
  }
  ul {
    list-style-type: none;
    padding: 5px;
    margin: 0;
    li {
      padding: 0;
      margin: 0;
      display: flex;
      margin-bottom: 10px;
      .orderItem-info-container {
        display: flex;
        flex-direction: column;
        padding: 0px 10px;
        .orderItem-name-quantity {
          display: flex;
          justify-content: space-between;
          .orderItem-name .orderItem-quantity {
            display: inline-block;
          }
          p {
            margin: 0;
          }
          h5 {
            margin: 0;
            font-weight: bold;
            font-size: 18px;
          }
        }
        .orderItem-choice-price {
          display: flex;
          justify-content: space-between;
          ul {
            li {
              padding: 0;
              margin: 0;
              font-size: 10px;
              color: #9b9b9b;
            }
          }
          .orderItem-price {
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
          }
          p {
            margin: 0;
            font-weight: bold;
            color: #f83f3a;
          }
        }
      }
    }
  }
  .payment-method {
    display: flex;
    flex-direction: column;
    .icon-group {
      display: flex;
      justify-content: space-around;
      .payment-choice {
        display: flex;
        flex-direction: column;
        justify-content: space-around;
      }
      p {
        margin: 0;
      }
    }
  }
  .payment-detail-container {
    display: table;
    width: 90%;
    margin: auto;
    div {
      display: table-row;
      span {
        display: table-cell;
        &.number {
          text-align: right;
        }
      }
    }
  }
  .footer {
    position: fixed;
    bottom: 0;
    width: 100%;
    .footer-content-container {
      display: flex;
      justify-content: space-between;
      padding: 0px 10px;
      .footer-title {
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        h2 {
          margin: 0;
        }
      }
      .footer-detail {
        flex: 1;
        padding: 0 20px;
        .footer-detail-info {
          font-size: 10px;
          text-align: center;
          color: #9b9b9b;
        }
        .footer-detail-total {
          font-size: 20px;
          text-align: right;
        }
      }
      .footer-button {
        display: flex;
        justify-content: center;
        flex-direction: column;
        width: 47px;
        background-color: #ef8282;
        text-align: center;
        color: yellow;
        margin-bottom: 5px;
      }
    }
  }
}
</style>
