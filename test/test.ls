require! {
  chai: {expect}
  '../': mona-width
}

It = global.it

describe 'Basic Usage' ->
  It 'returns width of character' ->
    expect mona-width \A
    .to.equal 648

    expect mona-width \!
    .to.equal 224

    expect mona-width \д
    .to.equal 1024

  It 'returns zero when the character is not defined' ->
    expect mona-width \█
    .to.equal 0

  It 'returns tatal width of characters when string is given' ->
    # 512 + 680 + 512 + 1024 + 512 + 512
    expect mona-width '（　´∀｀）'
    .to.equal 3752

  It 'coerces every input to the string' ->
    # 512 + 512 + 512
    expect mona-width 334
    .to.equal 1536
