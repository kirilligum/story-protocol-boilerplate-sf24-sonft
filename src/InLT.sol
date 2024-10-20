// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import { IPAssetRegistry } from "@storyprotocol/core/registries/IPAssetRegistry.sol";
import { LicensingModule } from "@storyprotocol/core/modules/licensing/LicensingModule.sol";
import { PILicenseTemplate } from "@storyprotocol/core/modules/licensing/PILicenseTemplate.sol";

import { SONFT } from "./SONFT.sol";

/// @notice Mint a License Token from Programmable IP License Terms attached to an IP Account.
contract InLT {
    IPAssetRegistry public immutable IP_ASSET_REGISTRY;
    LicensingModule public immutable LICENSING_MODULE;
    PILicenseTemplate public immutable PIL_TEMPLATE;
    uint256 public number;

    constructor(address ipAssetRegistry, address licensingModule, address pilTemplate) {
        IP_ASSET_REGISTRY = IPAssetRegistry(ipAssetRegistry);
        LICENSING_MODULE = LicensingModule(licensingModule);
        PIL_TEMPLATE = PILicenseTemplate(pilTemplate);
        // Create a new Simple NFT collection
    }

    function mintLicenseToken(
        uint256 ltAmount,
        address ltRecipient,
        address nftAddr
    ) external returns (address ipId, uint256 tokenId, uint256 startLicenseTokenId) {
        // First, mint an NFT and register it as an IP Account.
        // Note that first we mint the NFT to this contract for ease of attaching license terms.
        // We will transfer the NFT to the msg.sender at last.
        tokenId = 1;
        ipId = IP_ASSET_REGISTRY.register(block.chainid, nftAddr, tokenId);

        // Then, attach a selection of license terms from the PILicenseTemplate, which is already registered.
        // Note that licenseTermsId = 2 is a Non-Commercial Social Remixing (NSCR) license.
        // Read more about NSCR: https://docs.storyprotocol.xyz/docs/pil-flavors#flavor-1-non-commercial-social-remixing
        LICENSING_MODULE.attachLicenseTerms(ipId, address(PIL_TEMPLATE), 2);

        // Then, mint a License Token from the attached license terms.
        // Note that the License Token is minted to the ltRecipient.
        startLicenseTokenId = LICENSING_MODULE.mintLicenseTokens({
            licensorIpId: ipId,
            licenseTemplate: address(PIL_TEMPLATE),
            licenseTermsId: 2,
            amount: ltAmount,
            receiver: ltRecipient,
            royaltyContext: "" // for PIL, royaltyContext is empty string
        });

        // Finally, transfer the NFT to the msg.sender.
        // SIMPLE_NFT.transferFrom(address(this), msg.sender, tokenId);
    }

    function mintLi(
        uint256 ltAmount,
        address ltRecipient,
        address nftAddr
    ) external returns (address ipId, uint256 tokenId, uint256 startLicenseTokenId) {
        // First, mint an NFT and register it as an IP Account.
        // Note that first we mint the NFT to this contract for ease of attaching license terms.
        // We will transfer the NFT to the msg.sender at last.
        tokenId = 0;
        ipId = IP_ASSET_REGISTRY.register(block.chainid, nftAddr, tokenId);

        // Then, attach a selection of license terms from the PILicenseTemplate, which is already registered.
        // Note that licenseTermsId = 2 is a Non-Commercial Social Remixing (NSCR) license.
        // Read more about NSCR: https://docs.storyprotocol.xyz/docs/pil-flavors#flavor-1-non-commercial-social-remixing
        LICENSING_MODULE.attachLicenseTerms(ipId, address(PIL_TEMPLATE), 2);

        // Then, mint a License Token from the attached license terms.
        // Note that the License Token is minted to the ltRecipient.
        startLicenseTokenId = LICENSING_MODULE.mintLicenseTokens({
            licensorIpId: ipId,
            licenseTemplate: address(PIL_TEMPLATE),
            licenseTermsId: 2,
            amount: ltAmount,
            receiver: ltRecipient,
            royaltyContext: "" // for PIL, royaltyContext is empty string
        });

        // Finally, transfer the NFT to the msg.sender.
        // SIMPLE_NFT.transferFrom(address(this), msg.sender, tokenId);
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
