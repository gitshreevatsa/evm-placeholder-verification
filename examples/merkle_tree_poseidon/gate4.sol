
// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2022 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2022 Ilias Khairullin <ilias@nil.foundation>
// Copyright (c) 2022 Aleksei Moskvin <alalmoskvin@nil.foundation>
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

import "../../contracts/types.sol";
import "../../contracts/logging.sol";

// TODO: name component
library gate4{
    uint256 constant MODULUS_OFFSET = 0x0;
    uint256 constant THETA_OFFSET = 0x20;
    uint256 constant CONSTRAINT_EVAL_OFFSET = 0x40;
    uint256 constant GATE_EVAL_OFFSET = 0x60;
    uint256 constant GATES_EVALUATIONS_OFFSET = 0x80;
    uint256 constant THETA_ACC_OFFSET = 0xa0;
    uint256 constant WITNESS_EVALUATIONS_OFFSET = 0xc0;
    uint256 constant CONSTANT_EVALUATIONS_OFFSET = 0xe0;
    uint256 constant SELECTOR_EVALUATIONS_OFFSET =0x100;
    uint256 constant PUBLIC_INPUT_EVALUATIONS_OFFSET =0x120;

    function evaluate_gate_be(
        types.gate_argument_local_vars memory gate_params
    ) external pure returns (uint256 gates_evaluation, uint256 theta_acc) {
        gates_evaluation = gate_params.gates_evaluation;
        theta_acc = gate_params.theta_acc;
        uint256 terms;
        assembly {
            let modulus := mload(gate_params)
            mstore(add(gate_params, GATE_EVAL_OFFSET), 0)

            function get_witness_i_by_rotation_idx(idx, rot_idx, ptr) -> result {
                result := mload(
                    add(
                        add(mload(add(add(mload(add(ptr, WITNESS_EVALUATIONS_OFFSET)), 0x20), mul(0x20, idx))), 0x20),
                        mul(0x20, rot_idx)
                    )
                )
            }

            function get_selector_i(idx, ptr) -> result {
                result := mload(add(add(mload(add(ptr, SELECTOR_EVALUATIONS_OFFSET)), 0x20), mul(0x20, idx)))
            }

            function get_public_input_i(idx, ptr) -> result {
                result := mload(add(add(mload(add(ptr, PUBLIC_INPUT_EVALUATIONS_OFFSET)), 0x20), mul(0x20, idx)))
            }

            // rot_idx is temporary unused
            function get_constant_i_by_rotation_idx(idx, rot_idx, ptr) -> result {
                result := mload(add(add(mload(add(ptr, CONSTANT_EVALUATIONS_OFFSET)), 0x20), mul(0x20, idx)))
            }

			//Gate4
			mstore(add(gate_params, GATE_EVAL_OFFSET), 0)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x3009386b52e5055b6bf772a071193b84285e68e8c1c6d04bf9eb3e04ec7c1416
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x2f5ef53c118f839d17420d324b653d32e3d2c07eecdd7cbbc0da152db7fb0ea
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x229efeb32c10f2782fc83a94205c8f58eef3df9ec21e4c02616e6082ce7fe370
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x2dc1e7a4d1380f8daf853e1b18bca7646fea0920c2bec67d1b4bc765a06f3adc
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0xf487f3f3e34f9f69dc8cd7db38afe8278ccfd1f8b4443f3de453ce31424130f
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x2204c7fe4851b1df6097e6a9ed69a391eaa3ab9f175e0ade523f3a97290a5012
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(3,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(4,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(5,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x10211bd7fa4d88bf9b169c38beaadaaa20ac02ea76bf1ea90db4ffcee0fb6ad9
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0xe4d49a3bceded12c90225aca726f32656f4cf07758d01febcb7cba7b81b5dd6
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x21c35fcc27bec49772485abc19d53d198c01d89ac14bc17e9aca36cafce61f12
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(6,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(7,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(8,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x33710ee97bdafd73ad5cd26c06ceceac3d17fc0aaaee3666cf2360d5cf252bcf
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x8738cc8c5c95a126b5cb08a1a218585c0beaecbf5cc0c202a130e1d7aad9c73
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0xde75113dffb75a9bfea170dde9a8041d9aaf4f7315707c01690b67757a3d0bd
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(9,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(10,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(11,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0xced10834452cebcf0df0cf6ce4f8fc885cf875ff12732c58c5a68c0089886b3
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(0,1, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0xa9bb658ec7c98b39f805ce21273f3f2f5259db645e66049405e6354d245b875
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(1,1, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
			terms:=0x333772e36eb7e2acdee8b1aa4b64db7aba1a1101469f45e982b310304a824ca8
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(12,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(13,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(14,0, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			terms:=0x1
			terms:=mulmod(terms, get_witness_i_by_rotation_idx(2,1, gate_params), modulus)
			mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
			mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
			theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
			mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(4,gate_params),modulus))
			gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)

        }
    }
}