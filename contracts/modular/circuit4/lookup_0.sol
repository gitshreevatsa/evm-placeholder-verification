
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

library lookup_circuit4_0{
    uint256 constant modulus = 28948022309329048855892746252171976963363056481941560715954676764349967630337;
    
    function evaluate_gate_be(
        bytes calldata blob,
        uint256 theta,
        uint256 theta_acc,
        uint256 beta,
        uint256 gamma
    ) external pure returns (uint256 g, uint256) {
        uint256 l;
        uint256 selector_value;
        uint256 sum;
        uint256 prod;

		selector_value=basic_marshalling.get_uint256_be(blob, 288);
		g = 1;
		l = mulmod( 1,selector_value, modulus);
		theta_acc=theta;
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 512);
		sum = addmod(sum, prod, modulus);


		l = addmod( l, mulmod( mulmod(theta_acc, selector_value, modulus), sum, modulus), modulus);
		theta_acc = mulmod(theta_acc, theta, modulus);
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 544);
		sum = addmod(sum, prod, modulus);


		l = addmod( l, mulmod( mulmod(theta_acc, selector_value, modulus), sum, modulus), modulus);
		theta_acc = mulmod(theta_acc, theta, modulus);
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 576);
		sum = addmod(sum, prod, modulus);


		l = addmod( l, mulmod( mulmod(theta_acc, selector_value, modulus), sum, modulus), modulus);
		theta_acc = mulmod(theta_acc, theta, modulus);
		g = mulmod(g, mulmod(addmod(1, beta, modulus), addmod(l,gamma, modulus), modulus), modulus);

        return( g, theta_acc );
    }
}
        