program hello.aleo {
    // Mapping to store the random number.
    mapping random_number_storage: address => u8;

    // Mapping to store user balances.
    mapping user_balances: address => u8;

    // Define a transition function that receives the random number, final score, and bet amount.
    transition main(caller: address, final_score: u8, bet_amount: u8, dealer_number: u8) {
        return then finalize(caller, final_score, bet_amount, dealer_number);
    }

    // Define a finalize function to handle the game logic and update balances.
    finalize main(caller: address, final_score: u8, bet_amount: u8, dealer_number: u8) {
        // Retrieve the current balance for the caller
        let current_balance: u8 = Mapping::get_or_use(user_balances, caller, 0u8);

        // Check if the user's score is greater than 21
        if final_score > 21u8 {
            // User loses: Deduct the bet amount from their balance
            
            // assert!(current_balance >= bet_amount, "Insufficient balance");
            Mapping::set(user_balances, caller, current_balance - bet_amount);
        } else if dealer_number > 21u8 {
            // Dealer loses: Double the user's bet amount in their balance
            Mapping::set(user_balances, caller, current_balance + bet_amount * 2u8);
        } else if final_score > dealer_number {
            // User wins: Double the user's bet amount in their balance
            Mapping::set(user_balances, caller, current_balance + bet_amount * 2u8);
        } else if final_score == dealer_number {
            // Draw: User's balance remains the same
            Mapping::set(user_balances, caller, current_balance);
        } else {
            // User loses: Deduct the bet amount from their balance
            // assert!(current_balance >= bet_amount, "Insufficient balance");
            Mapping::set(user_balances, caller, current_balance - bet_amount);
        }
    }
}
