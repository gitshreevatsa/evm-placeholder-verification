// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2022 Mikhail Komarov <nemo@nil.foundation>
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

import "../contracts/types.sol";
import "../contracts/basic_marshalling.sol";
import "../contracts/commitments/batched_lpc_verifier.sol";
import "./gate0.sol";
import "./gate1.sol";
import "./gate2.sol";
import "./gate3.sol";
import "./gate4.sol";
import "./gate8.sol";
import "./gate9.sol";
import "./gate10.sol";
import "./gate11.sol";
import "./gate12.sol";
import "./gate13.sol";
import "./gate14.sol";
import "./gate15.sol";
import "./gate16.sol";
import "./gate17.sol";
import "./gate18.sol";
import "./gate19.sol";
import "./gate20.sol";
import "./gate21.sol";
import "./gate22.sol";

// TODO: name component
contract gate_argument_split_gen {
    // TODO: specify constants
    uint256 constant WITNESSES_N = 15;
    uint256 constant SELECTOR_N = 1;
    uint256 constant PUBLIC_INPUT_N = 1;
    uint256 constant GATES_N = 23;
    uint256 constant CONSTANTS_N = 1;

    // TODO: columns_rotations could be hard-coded
    function evaluate_gates_be(
        bytes calldata blob,
        types.gate_argument_local_vars memory gate_params,
        types.arithmetization_params memory ar_params,
        int256[][] memory columns_rotations
    ) external pure returns (uint256 gates_evaluation) {
        // TODO: check witnesses number in proof
        gate_params.witness_evaluations = new uint256[][](WITNESSES_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_witness_offset);
        for (uint256 i = 0; i < WITNESSES_N; i++) {
            gate_params.witness_evaluations[i] = new uint256[](columns_rotations[i].length);
            for (uint256 j = 0; j < columns_rotations[i].length; j++) {
                gate_params.witness_evaluations[i][j] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(blob, gate_params.offset, i, j);
            }
        }

        gate_params.selector_evaluations = new uint256[](GATES_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_selector_offset);
        for (uint256 i = 0; i < GATES_N; i++) {
            gate_params.selector_evaluations[i] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(
                blob, 
                gate_params.offset, 
                i + ar_params.permutation_columns + ar_params.permutation_columns + ar_params.constant_columns, 
                0
            );
        }

        gate_params.constant_evaluations = new uint256[][](CONSTANTS_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_constant_offset);
        for (uint256 i = 0; i < CONSTANTS_N; i++) {
            gate_params.constant_evaluations[i] = new uint256[](columns_rotations[i].length);
            for (uint256 j = 0; j < columns_rotations[i].length; j++) {
                gate_params.constant_evaluations[i][j] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(
                    blob, 
                    gate_params.offset, 
                    i + ar_params.permutation_columns + ar_params.permutation_columns, 
                    j
                );
            }
        }

        gate_params.theta_acc = 1;
        gate_params.gates_evaluation = 0;
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate0.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate1.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate2.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate3.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate4.evaluate_gate_be(gate_params, columns_rotations);
//       This contain gate4
//        (gate_params.gates_evaluation, gate_params.theta_acc) = gate5
//            .evaluate_gate_be(gate_params, columns_rotations);
//        (gate_params.gates_evaluation, gate_params.theta_acc) = gate6
//            .evaluate_gate_be(gate_params, columns_rotations);
//        (gate_params.gates_evaluation, gate_params.theta_acc) = gate7
//            .evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate8.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate9.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate10.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate11.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate12.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate13.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate14.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate15.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate16.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate17.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate18.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate19.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate20.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate21.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate22.evaluate_gate_be(gate_params, columns_rotations);
        gates_evaluation = gate_params.gates_evaluation;
    }
}