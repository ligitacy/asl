state("Matrix") {
    bool inSaveConfirmation : "Matrix.exe", 0x57ECDC;
    int gameState: 0xA9A1C8;
}
start {
    return (old.gameState == 38) && (old.gameState != current.gameState);
}
split {
    return old.inSaveConfirmation && !current.inSaveConfirmation;
}
isLoading {
    return current.gameState == 42;
}
