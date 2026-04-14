## HW6 Frontend (Bonus)

This is a minimal web UI to interact with the `Whirlwind` mixer contract.

### What it does
- Connects to MetaMask
- Reads on-chain state (`currentRoot`, `depositIndex`, verifier addresses)
- Listens for the `Deposit` event to stay in sync
- Lets a user submit:
  - `deposit(proof, newRoot, commitment)` with exactly **0.1 ETH**
  - `withdraw(proof, nullifier)` (this contract uses `id` as the nullifier)

### Run locally
From the `frontend/` folder:

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000` in a browser with MetaMask installed.

### Recommended: load `target/proof` from file (no copy/paste)
The `target/proof` files produced by `bb prove` can be very large. Copy/paste can silently truncate them,
which will make the on-chain verifier revert.

This UI supports selecting the proof file directly:
- Deposit: `../contracts/deposit_circuit/target/proof`
- Withdraw: `../contracts/withdraw_circuit/target/proof`

### Using the UI (Deposit + Withdraw)
1. Paste your deployed **Whirlwind** address into the "Whirlwind contract address" box.
2. Click **Connect MetaMask** (make sure MetaMask is on **Sepolia**).
3. Click **Refresh state** to confirm `currentRoot` and `depositIndex`.

#### Deposit (0.1 ETH)
1. In the Deposit section, choose file:
   - `../contracts/deposit_circuit/target/proof`
2. Enter:
   - **New root**: the `newRoot` from `contracts/deposit_circuit/Prover.toml`
   - **Commitment**: the `commitment` from `contracts/deposit_circuit/Prover.toml`
3. Click **Submit deposit** and approve the MetaMask transaction (sends exactly **0.1 ETH**).

#### Withdraw (0.1 ETH)
1. Generate the withdraw proof, which produces:
   - `../contracts/withdraw_circuit/target/proof`
2. In the Withdraw section, choose file:
   - `../contracts/withdraw_circuit/target/proof`
3. Set **Nullifier** to the `id` value from:
   - `../contracts/withdraw_circuit/Prover.toml`
4. Click **Submit withdraw** and approve the MetaMask transaction.

### Notes
- The proof file must be submitted **as bytes**. The UI uses the file picker to avoid truncation.
- The `Whirlwind` contract constructs verifier public inputs internally:
  - Deposit: `[currentRoot, newRoot, commitment, depositIndex]`
  - Withdraw: `[currentRoot, nullifier]`

