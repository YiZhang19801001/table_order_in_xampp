import Payment from "./components/Payment.vue";
import Order from "./components/Order.vue";
import Menu from "./components/Menu.vue";

export const routes = [
    //<- all router configrations goes here.
    {
        path: "/table/public/table/:table/orderid/:orderid",
        component: Order
    },
    {
        path: "/table/public/table/:table/orderid/:orderid/payment",
        component: Payment
    },
    {
        path: "/table/public/menu",
        component: Menu
    }
];
