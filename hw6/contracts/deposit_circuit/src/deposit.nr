use ::merkle_trees::compute_merkle_root;
use ::std::hash::pedersen_hash;

fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field,
) {
    let computed_commitment = pedersen_hash([id, r]);
    assert(computed_commitment == commitment);

    let empty_leaf: Field =
        0x2df8b940e5890e4e1377e05373fae69a1d754f6935e6a780b666947431f2cdcd;

    let computed_old_root = compute_merkle_root::<8>(empty_leaf, index, oldPath);
    assert(computed_old_root == oldRoot);

    let computed_new_root = compute_merkle_root::<8>(commitment, index, oldPath);
    assert(computed_new_root == newRoot);
}
