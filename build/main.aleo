program hello.aleo;



mapping random_number_storage:
	key as address.public;
	value as u8.public;

function main:
    input r0 as address.private;
    async main r0 into r1;
    output r1 as hello.aleo/main.future;

finalize main:
    input r0 as address.public;
    rand.chacha into r1 as u8;
    rem r1 13u8 into r2;
    add r2 1u8 into r3;
    set r3 into random_number_storage[r0];
