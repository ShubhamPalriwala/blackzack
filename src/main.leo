// Random number generator program.
program hello.aleo {
    // Declare a mapping to store the random number.
    mapping random_number_storage: address => u8;

    // Define a transition function that initiates the random number generation process.
    transition main(caller: address) {
        return then finalize(caller);
    }

    // Define a finalize function where the actual random number generation happens.
    finalize main(caller: address) {
        // Generate a random u8 number within the finalize block.
        let random_value: u8 = ChaCha::rand_u8();

        // Modulo operation to bring it within the range of 1 to 13.
        let result: u8 = (random_value % 13u8) + 1u8;

        // Store the generated random number in the mapping with the caller's address.
        Mapping::set(random_number_storage, caller, result);
    }

    transition get(caller: address) {

        // Store the generated random number in the mapping with the caller's address.
        Mapping::get(random_number_storage, caller);
    }

    // // Define a transition function to retrieve the generated random number.
    // transition use_generated_number(caller: address) -> u8 {
    //     // Retrieve the random number from the mapping.
    //     let stored_random_number: u8 = Mapping::get(random_number_storage, caller);

    //     // Here, you can use `stored_random_number` for further computation.

    //     return stored_random_number;
    // }
}
