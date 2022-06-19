import { useState } from "react";
import {ethers, BigNumber} from 'ethers';
import SelfDevsNFT from './SelfDevsNFT.json';

// Contract address for the Self Devs NFT solidity contract
const SelfDevsNFTAddress = '0x3E3A6002553d731761657d2F33896235cB49440b';

const MainMint = ({accounts, setAccounts}) => {
    const [minAmount, setMintAmount] = useState(1);
    const isConnected = Boolean(accounts[0]);

    async function handleMint() {
        if (window.ethereum) {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(
                SelfDevsNFTAddress,
                SelfDevsNFT.abi,
                signer
            );
            try {
                
            } catch (error) {
                
            }
        }
    }
}