program hello.aleo;



mapping random_number_storage:
	key as address.public;
	value as u8.public;


mapping user_balances:
	key as address.public;
	value as u8.public;

function main:
    input r0 as address.private;
    input r1 as u8.private;
    input r2 as u8.private;
    input r3 as u8.private;
    async main r0 r1 r2 r3 into r4;
    output r4 as hello.aleo/main.future;

finalize main:
    input r0 as address.public;
    input r1 as u8.public;
    input r2 as u8.public;
    input r3 as u8.public;
    get.or_use user_balances[r0] 0u8 into r4;
    gt r1 21u8 into r5;
    sub r4 r2 into r6;
    set r6 into user_balances[r0];
    gt r3 21u8 into r7;
    mul r2 2u8 into r8;
    add r4 r8 into r9;
    set r9 into user_balances[r0];
    gt r1 r3 into r10;
    mul r2 2u8 into r11;
    add r4 r11 into r12;
    set r12 into user_balances[r0];
    is.eq r1 r3 into r13;
    set r4 into user_balances[r0];
    sub r4 r2 into r14;
    set r14 into user_balances[r0];
