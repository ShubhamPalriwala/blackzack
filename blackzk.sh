#!/bin/bash

# Function to generate a random card value between 1 and 11
get_card() {
    echo $(((RANDOM % 11) + 1))
}

echo "📝 Enter your Aleo address: "
read aleo_address

echo "💰 Enter the amount you want to bet: "
read bet_amount

player_score=0
dealer_score=0

# Player's turn
while true; do
    card=$(get_card)
    player_score=$((player_score + card))
    echo "🃏 You got a $card. Your total score is: $player_score"

    if ((player_score > 21)); then
        echo "😢 Oops! Your score exceeded 21. You lose!"
        break
    elif ((player_score == 21)); then
        echo "🎉 Congratulations! You hit 21!"
        break
    fi

    echo -n "🤔 Do you want another card? (y/n) "
    read choice

    if [ "$choice" != "y" ]; then
        break
    fi
done

# Dealer's turn
if ((player_score <= 21)); then
    while ((dealer_score < 15)); do
        card=$(get_card)
        dealer_score=$((dealer_score + card))
        echo "🔀 Dealer got a $card. Dealer's total score is: $dealer_score"
    done

    if ((dealer_score > 21)); then
        echo "🏆 Dealer's score exceeded 21! You win!"
    fi
fi

# Determine the result
if ((player_score <= 21 && dealer_score <= 21)); then
    if ((player_score == dealer_score)); then
        echo "🤝 It's a draw!"
    elif ((player_score > dealer_score)); then
        echo "🥳 You win!"
    else
        echo "👎 Dealer wins!"
    fi
fi

# Submit the final result to snarkvm
echo "📤 Submitting transaction on Aleo ZK..."
snarkvm run blackzk $aleo_address $bet_amount"u8" $player_score"u8" $dealer_score"u8"

echo "🙏 Thanks for playing BlackZK!"
