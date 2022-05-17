import React from "react";

const NavBar = ({accounts, setAccounts}) => {
    const isConnected = Boolean(accounts[0]);

    async function connectAccount(){
        if (typeof window.ethereum !== "undefined"){
            const accounts = await window.ethereum.request({
                method: "eth_requestAccounts",
            });
            setAccounts(accounts);
        }
    }

    return (
        <div>
            {/* Left side - Social Media Icons*/}
            <div>Facebook</div>
            <div>Twitter</div>
            <div>Email</div>

            {/* Right side - Sections and connect*/}
            <div>Email</div>
            <div>Mint</div>
            <div>Team</div>

            {/* Connect */}
            {isConnected ? (
                
            )}
        </div>
    )
}