export const selectDealer =  (store, dealerId) => {
    store.setState({ selectedDealer: dealerId });
};
