from web3_test import do_placeholder_verification_test_via_transact, base_path, do_placeholder_verification_test_via_transact_simple

test_contract_name = 'TestPlaceholderVerifierUnifiedAddition'
test_contract_path = 'placeholder/test/public_api_placeholder_unified_addition_component.sol'
# linked_gates_entry_lib_name = "unified_addition_component_gen"
linked_libs_names = ["unified_addition_component_gen", "placeholder_verifier"]


def init_test1():
    params = dict()
    params['_test_name'] = "Placeholder proof verification for unified addition (case 1)"
    f = open(base_path + '/test/data/placeholder_proof1.txt')
    params["proof"] = f.read()
    f.close()

    params['init_params'] = []
    params['init_params'].append(
        28948022309329048855892746252171976963363056481941560715954676764349967630337)
    params['init_params'].append(2)
    params['init_params'].append(7)
    params['init_params'].append(2)
    params['init_params'].append(8)
    params['init_params'].append(199455130043951077247265858823823987229570523056509026484192158816218200659)
    params['init_params'].append(13)
    D_omegas = []
    f = open(base_path + '/test/data/domain8_unified_addition.txt')
    lines = f.readlines()
    for line in lines:
        D_omegas.append(int(line))
    f.close()
    params['init_params'].append(len(D_omegas))
    params['init_params'].extend(D_omegas)
    q = [0, 0, 1]
    params['init_params'].append(len(q))
    params['init_params'].extend(q)

    step_list = [1, 1]
    params['init_params'].append(len(step_list))
    params['init_params'].extend(step_list)  # step_list

    params['columns_rotations'] = []
    for i in range(14):
        params['columns_rotations'].append([0, ])


    return params


def init_test2():
    params = dict()
    params['_test_name'] = "Placeholder proof verification for unified addition (case 2)"
    f = open(base_path + '/test/data/placeholder_proof2.txt')
    params["proof"] = f.read()
    f.close()

    params['init_params'] = []
    params['init_params'].append(
        28948022309329048855892746252171976963363056481941560715954676764349967630337)  # modulus+
    params['init_params'].append(2)  # r
    params['init_params'].append(7)  # max_degree
    params['init_params'].append(2)  # lambda
    params['init_params'].append(8)  # rows_amount
    params['init_params'].append(
        199455130043951077247265858823823987229570523056509026484192158816218200659)  # 1st domen?
    params['init_params'].append(13)  # 12 true value but hm
    D_omegas = []
    f = open(base_path + '/test/data/domain8_unified_addition.txt')
    lines = f.readlines()
    for line in lines:
        D_omegas.append(int(line))
    f.close()
    params['init_params'].append(len(D_omegas))
    params['init_params'].extend(D_omegas)
    q = [0, 0, 1]
    params['init_params'].append(len(q))
    params['init_params'].extend(q)

    params['columns_rotations'] = []

    step_list = [1, 1]
    params['init_params'].append(len(step_list))
    params['init_params'].extend(step_list)  # step_list

    for i in range(14):
        params['columns_rotations'].append([0, ])

    return params


if __name__ == '__main__':
    do_placeholder_verification_test_via_transact_simple(test_contract_name, test_contract_path, linked_libs_names, init_test1)
    do_placeholder_verification_test_via_transact_simple(test_contract_name, test_contract_path, linked_libs_names, init_test2)
    # do_placeholder_verification_test_via_transact(test_contract_name, test_contract_path, linked_gates_entry_lib_name, linked_libs_names, init_test1)
    # do_placeholder_verification_test_via_transact(test_contract_name, test_contract_path, linked_gates_entry_lib_name, linked_libs_names, init_test2)