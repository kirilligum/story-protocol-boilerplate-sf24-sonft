// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import { IPAssetRegistry } from "@storyprotocol/core/registries/IPAssetRegistry.sol";
import { LicensingModule } from "@storyprotocol/core/modules/licensing/LicensingModule.sol";
import { PILicenseTemplate } from "@storyprotocol/core/modules/licensing/PILicenseTemplate.sol";

import { SONFT } from "./SONFT.sol";

/// @notice Mint a License Token from Programmable IP License Terms attached to an IP Account.
contract IPALicenseToken {
    IPAssetRegistry public immutable IP_ASSET_REGISTRY;
    LicensingModule public immutable LICENSING_MODULE;
    PILicenseTemplate public immutable PIL_TEMPLATE;
    address inNft_addr;
    address fsIpId;

    constructor(address ipAssetRegistry, address licensingModule, address pilTemplate, address royaltyModule, address inNft_addr_) {
        IP_ASSET_REGISTRY = IPAssetRegistry(ipAssetRegistry);
        LICENSING_MODULE = LicensingModule(licensingModule);
        PIL_TEMPLATE = PILicenseTemplate(pilTemplate);
        ROYALTY_MODULE = RoyaltyModule(royaltyModule);
        inNft_addr = inNft_addr_;
    }

    function mintDerivative(uint256 inLT)
    {
      address childIpId = ipAssetRegistry.register(block.chainid, inNft_addr, tokenId);
      fsIpId = childIpId;

      uint256[] memory licenseTokenIds = new uint256[](1);
      licenseTokenIds[0] = inLT;

      licensingModule.registerDerivativeWithLicenseTokens({
        childIpId: childIpId,
        licenseTokenIds: licenseTokenIds,
        royaltyContext: "" // empty for PIL
      });
    }
    function pay(address token, uint256 amount){
      ROYALTY_MODULE.payRoyaltyOnBehalf( fsIpId, 0, token, amount);
      // ROYALTY_MODULE.payRoyaltyOnBehalf( parentIpId, fsIpId, token, amount);
    }
}
