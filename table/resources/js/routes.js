import MainApp from "./components/MainApp.vue";
import Payment from "./components/Payment.vue";
import Order from "./components/Order.vue";

export const routes = [
    //<- all router configrations goes here.
    { path: "/table/public/table/:table/orderid/:orderid", component: Order },
    {
        path: "/table/public/table/:table/orderid/:orderid/payment",
        component: Payment
    }
];
