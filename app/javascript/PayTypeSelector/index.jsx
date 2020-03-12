import React from 'react'
import NoPayType from './NoPayType'
import CreditCardPayType from './CreditCardPayType'
import ChequePayType from './ChequePayType'
import PurchaseOrderPayType from './PurchaseOrderPayType'

class PayTypeSelector extends React.Component {
    constructor(props) {
        super(props);
        this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
        this.state = {selectedPayType: null}
    }

    onPayTypeSelected(event) {
        this.setState({selectedPayType: event.target.value});
    }

    render() {
        let PayTypeCustomComponent = NoPayType;
        if (this.state.selectedPayType == "Cheque") {
            PayTypeCustomComponent = ChequePayType;
        } else if (this.state.selectedPayType == "Credit Card") {
            PayTypeCustomComponent = CreditCardPayType;
        } else if (this.state.selectedPayType == "Purchase Order") {
            PayTypeCustomComponent = PurchaseOrderPayType;
        }

        return (
            <div>
                <div className="field">
                    <label htmlFor="order_pay_type">{I18n.t('orders.form.pay_type')}</label>
                    <select id="pay_type" onChange={this.onPayTypeSelected} name="order[pay_type]">
                        <option value="">{I18n.t('orders.form.pay_prompt')}</option>
                        <option value="Cheque">{I18n.t('orders.form.pay_types.cheque')}</option>
                        <option value="Credit Card">{I18n.t('orders.form.pay_types.credit_card')}</option>
                        <option value="Purchase Order">{I18n.t('orders.form.pay_types.purchase_order')}</option>
                    </select>
                </div>
                <PayTypeCustomComponent />
            </div>
        );
    }
}

export default PayTypeSelector
