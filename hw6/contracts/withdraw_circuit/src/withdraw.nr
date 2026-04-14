use ::merkle_trees::compute_merkle_root;
use ::std::hash::pedersen_hash;

fn main(
    r: Field,
    index: Field,
    hashpath: [Field; 8],
    root: pub Field,
    id: pub Field,
) {
    let commitment = pedersen_hash([id, r]);
    let computed_root = compute_merkle_root::<8>(commitment, index, hashpath);
    assert(computed_root == root);
}
