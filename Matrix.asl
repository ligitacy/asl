state("Matrix") {
    bool inSaveConfirmation : "Matrix.exe", 0x592E44;
}
start {
    return old.inSaveConfirmation && !current.inSaveConfirmation;
split {
    return old.inSaveConfirmation && !current.inSaveConfirmation;
}
