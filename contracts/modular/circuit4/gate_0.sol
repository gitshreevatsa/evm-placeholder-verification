
// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c)  2023 -- Generated by zkllvm-transpiler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//---------------------------------------------------------------------------//
pragma solidity >=0.8.4;

import "../../../contracts/basic_marshalling.sol";
import "./gate_argument.sol";

library gate_circuit4_0{
    uint256 constant modulus = 28948022309329048855892746252171976963363056481941560715954676764349967630337;
    
    function evaluate_gate_be(
        bytes calldata blob,
        uint256 theta,
        uint256 theta_acc
    ) external pure returns (uint256 F, uint256) {
        uint256 sum;
        uint256 gate;
        uint256 prod;
        
		gate = 0;
		sum = 0;
		prod = 28948022309329048855892746252171976963363056481941560715954676764349967630336;
		prod = mulmod(prod, basic_marshalling.get_uint256_be(blob, 576), modulus);
		sum = addmod(sum, prod, modulus);
		prod = basic_marshalling.get_uint256_be(blob, 512);
		prod = mulmod(prod, basic_marshalling.get_uint256_be(blob, 544), modulus);
		sum = addmod(sum, prod, modulus);
		gate = addmod(gate, mulmod(theta_acc, sum, modulus), modulus);
		theta_acc = mulmod(theta_acc, theta, modulus);
		gate = mulmod(gate, basic_marshalling.get_uint256_be(blob, 352), modulus);
		F = addmod(F, gate, modulus);

        return( F, theta_acc );
    }
}
        