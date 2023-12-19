program blackzk.aleo {
    mapping user_balances: address => u8;

    transition blackzk(caller: address, final_score: u8, bet_amount: u8, dealer_number: u8) {
        return then finalize(caller, final_score, bet_amount, dealer_number);
    }

    finalize blackzk(caller: address, final_score: u8, bet_amount: u8, dealer_number: u8) {
        let current_balance: u8 = Mapping::get_or_use(user_balances, caller, 0u8);

        if final_score > 21u8 {
            Mapping::set(user_balances, caller, current_balance - bet_amount);
        } else if dealer_number > 21u8 {
            Mapping::set(user_balances, caller, current_balance + bet_amount * 2u8);
        } else if final_score > dealer_number {
            Mapping::set(user_balances, caller, current_balance + bet_amount * 2u8);
        } else if final_score == dealer_number {
            Mapping::set(user_balances, caller, current_balance);
        } else {
            Mapping::set(user_balances, caller, current_balance - bet_amount);
        }
    }
}
