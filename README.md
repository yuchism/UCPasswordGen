# UCPasswordGen
Utility classs for generating a random password with various options.

# How to use
```swift
let pwdGen = UCPasswordGen()
pwdGen.minimumLength = 10
pwdGen.requireNumbers = true
pwdGen.requireLowercase = true
pwdGen.requireUppercase = true
pwdGen.requireSpecialChar = true

print(pwdGen.getPassword())
```
