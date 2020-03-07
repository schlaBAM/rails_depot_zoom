import React from 'react'

class CreditCardPayType extends React.Component {
    render() {
        return (
            <div>
                <div className="field">
                    <label htmlFor="order_credit_card_number">CC Number</label>
                    <input type="password"
                           name="order[credit_card_number]"
                           id="order_credit_card_number"
                           autoComplete="cc-number"/>
                </div>
                <div className="field">
                    <label htmlFor="order_expiration_date">Expiry</label>
                    <input type="text"
                           name="order[expiration_date]"
                           id="order_expiration_date"
                           size="9"
                           placeholder="e.g. 03/19"
                           autoComplete="cc-exp"/>
                </div>
            </div>
        );
    }
}

export default CreditCardPayType