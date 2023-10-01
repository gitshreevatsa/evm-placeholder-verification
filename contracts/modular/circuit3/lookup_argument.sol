
// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2023 Generated by ZKLLVM-transpiler
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

import "../../cryptography/transcript.sol";
// Move away unused structures from types.sol
import "../../types.sol";
import "../../basic_marshalling.sol";
import "../../cryptography/transcript.sol";
import "../../interfaces/modular_lookup_argument.sol";
import "hardhat/console.sol";

contract modular_lookup_argument_circuit3 is ILookupArgument{
//library modular_lookup_argument_circuit3{
    uint256 constant modulus = 28948022309329048855892746252171976963363056481941560715954676764349967630337;
    uint8 constant tables = 1;
    uint8 constant sorted_columns = 2;
    uint8 constant lookup_options_num = 1;
    uint8 constant lookup_constraints_num = 1;


    struct lookup_state{
        uint256 theta;
        uint256 beta;
        uint256 gamma;
        uint256 factor;
        uint256 V_L_value;
        uint256 V_L_shifted_value;
        uint256 q_last;
        uint256 q_blind;
        uint256 mask;
        uint256 shifted_mask;
        uint256 selector_value;
        uint256 shifted_selector_value;
        uint256 theta_acc;
        uint256 g;
        uint256 h;
        uint256 l_shifted;
    }

    function verify(        
        bytes calldata zvalues, // Table values and permutations' values
        bytes calldata sorted, // Sorted batch values
        uint256 lookup_commitment,
        uint256 l0,
        bytes32 tr_state_before // It's better than transfer all random values
    ) external view returns (uint256[4] memory F, bytes32 tr_state_after){
        bytes calldata blob = zvalues[0xc0:];
        lookup_state memory state;
        state.V_L_value = basic_marshalling.get_uint256_be(zvalues, 0xc0 + 544 + 0x40);
        state.V_L_shifted_value = basic_marshalling.get_uint256_be(zvalues, 0xc0 + 544 + 0x60);
        state.q_last = basic_marshalling.get_uint256_be(zvalues, 0x0);
        state.q_blind = basic_marshalling.get_uint256_be(zvalues, 0x60);
        state.mask = addmod(1, modulus - addmod(state.q_last , state.q_blind, modulus), modulus);
        F[2] = state.mask;

        state.shifted_mask = addmod(
            1, 
            modulus - addmod(basic_marshalling.get_uint256_be(zvalues, 0x20) , basic_marshalling.get_uint256_be(zvalues, 0x80), modulus), 
            modulus
        );

        types.transcript_data memory tr_state;
        tr_state.current_challenge = tr_state_before;
        {
            state.theta = transcript.get_field_challenge(tr_state, modulus); //theta
            uint256 l;
            state.g = 1;
            state.h = 1;

            transcript.update_transcript_b32(tr_state, bytes32(lookup_commitment));
            state.beta = transcript.get_field_challenge(tr_state, modulus); //beta
            state.gamma = transcript.get_field_challenge(tr_state, modulus); //gamma
            state.factor = mulmod(addmod(1, state.beta, modulus), state.gamma, modulus);

			uint256 sum;
			uint256 prod;
			state.selector_value=basic_marshalling.get_uint256_be(blob, 288);
			l = mulmod( 1,state.selector_value, modulus);
			state.theta_acc=state.theta;
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 448);
		sum = addmod(sum, prod, modulus);


			l = addmod( l, mulmod( mulmod(state.theta_acc, state.selector_value, modulus), sum, modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 480);
		sum = addmod(sum, prod, modulus);


			l = addmod( l, mulmod( mulmod(state.theta_acc, state.selector_value, modulus), sum, modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 512);
		sum = addmod(sum, prod, modulus);


			l = addmod( l, mulmod( mulmod(state.theta_acc, state.selector_value, modulus), sum, modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
state.g = mulmod(state.g, mulmod(addmod(1, state.beta, modulus), addmod(l,state.gamma, modulus), modulus), modulus);

		state.selector_value=basic_marshalling.get_uint256_be(blob, 352);
		state.shifted_selector_value=basic_marshalling.get_uint256_be(blob, 384);
			l= mulmod( 1, state.selector_value, modulus);
			state.l_shifted = mulmod( 1, state.shifted_selector_value, modulus);
			state.theta_acc=state.theta;
			l= addmod( l, mulmod(state.selector_value,  mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 0), modulus), modulus), modulus);
			state.l_shifted = addmod( state.l_shifted, mulmod(state.shifted_selector_value, mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 32), modulus), modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
			l= addmod( l, mulmod(state.selector_value,  mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 96), modulus), modulus), modulus);
			state.l_shifted = addmod( state.l_shifted, mulmod(state.shifted_selector_value, mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 128), modulus), modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
			l= addmod( l, mulmod(state.selector_value,  mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 192), modulus), modulus), modulus);
			state.l_shifted = addmod( state.l_shifted, mulmod(state.shifted_selector_value, mulmod( state.theta_acc, basic_marshalling.get_uint256_be(blob, 224), modulus), modulus), modulus);
			state.theta_acc = mulmod(state.theta_acc, state.theta, modulus);
			l= mulmod( l, state.mask, modulus);
			state.l_shifted = mulmod( state.l_shifted, state.shifted_mask, modulus);
			 state.g = mulmod(state.g, addmod( state.factor, addmod(l, mulmod(state.beta, state.l_shifted, modulus), modulus), modulus), modulus);


        }
        {
            for(uint64 k = 0; k < 2;){
                state.mask = basic_marshalling.get_uint256_be(sorted, k*0x60); 
                state.shifted_mask = basic_marshalling.get_uint256_be(sorted, k*0x60 + 0x20);
                state.h = mulmod(
                    state.h, 
                    addmod(
                        addmod(
                            state.factor, 
                            state.mask,
                            modulus
                        ),
                        mulmod(state.beta, state.shifted_mask , modulus),
                        modulus
                    ),
                    modulus
                );
                unchecked{k++;}
            }
        }

        F[0] = mulmod(
            l0, 
            addmod(1, modulus - state.V_L_value, modulus),
            modulus
        );
        F[1] = mulmod(
            mulmod(state.q_last, state.V_L_value, modulus),
            addmod(state.V_L_value, modulus-1, modulus),
            modulus
        );
        {
            F[2] = mulmod(
                F[2], 
                addmod(
                    mulmod(state.h, state.V_L_shifted_value, modulus),
                    modulus - mulmod(state.V_L_value, state.g, modulus), 
                    modulus
                ), 
                modulus
            );
        }
        {
            for(uint64 i = 0; i < sorted_columns - 1;){
                state.beta = basic_marshalling.get_uint256_be(sorted, (i+1)*0x60); 
                state.gamma = modulus - basic_marshalling.get_uint256_be(sorted, (i)*0x60 + 0x40);
                F[3] = addmod(
                    F[3],
                    mulmod(
                        mulmod(
                            transcript.get_field_challenge(tr_state, modulus), //alpha
                            l0,
                            modulus
                        ),
                        addmod( 
                            state.beta,
                            state.gamma, 
                            modulus
                        ),
                        modulus
                    ),
                    modulus
                );
                unchecked{i++;}
            }
        }
        tr_state_after = tr_state.current_challenge;
    }
}            
        