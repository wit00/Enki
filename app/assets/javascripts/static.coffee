# Far from the prettiest code I've ever written. Lots of need for generalization and reuse here. This thing is so not dry, it's wet.
scalar = 1 
matrix = [1,2,3,4,5,6]
scaled_matrix = []
dot_matrix_1 = [[1,2,3],[4,5,6]]
dot_matrix_2 = [[7,8],[9,10],[11,12]]

@set_up_scalar_form = () ->
    set_question_string_for_scalar_form()
    set_answer_string_for_scalar_form()

@set_up_dot_product_form = () ->
    set_question_string_for_dot_product_form()
    set_answer_string_for_dot_product_form()

@get_initial_dot_product_demo = () ->
    document.getElementById("dot_product_demo").innerHTML = "\\[" + return_real_matrix_html(dot_matrix_1) + "*" +return_real_matrix_html(dot_matrix_2)+ " = " + return_real_matrix_html(matrix_multiplication(dot_matrix_1,dot_matrix_2)) + "\\]"

@get_initial_scalar_demo = () ->
    document.getElementById("scalar_demo").innerHTML = "\\[1*\\begin{bmatrix} 1 & 2 & 3 \\\\ 4 & 5 & 6 \\end{bmatrix} = \\begin{bmatrix} 1 & 2 & 3 \\\\ 4 & 5 & 6 \\end{bmatrix} \\]"

reload_typeset = () ->
    MathJax.Hub.Queue(["Typeset",MathJax.Hub])

return_matrix_html = () ->
    return scalar + "*\\begin{bmatrix}" + matrix[0] + " & " + matrix[1] + " & " + matrix[2] + "\\\\"+ matrix[3] + " & " + matrix[4] + " & " + matrix[5] + " \\end{bmatrix} = "

return_real_matrix_html = (matrix) ->
    html_first_part = "\\begin{bmatrix}"
    html_matrix_part = ""
    for row,row_index in matrix
        for element,element_index in row
            html_matrix_part = html_matrix_part + element
            html_matrix_part = html_matrix_part + " & " if element_index != row.length - 1
        html_matrix_part = html_matrix_part + "\\\\" if row_index != matrix.length - 1
    html_final_part = " \\end{bmatrix}"
    return html_first_part + html_matrix_part + html_final_part


generate_random = (max) ->
    return Math.floor(Math.random() * max)
    
@reload_dot_product_matrix = () -> 
    dot_matrix_1 = (generate_random(13) for num in element for element in dot_matrix_1)
    dot_matrix_2 = (generate_random(13) for num in element for element in dot_matrix_2)
    set_up_dot_product_form()
    get_initial_dot_product_demo()
    reload_typeset()

@reload_scalar_product_matrix = () ->
    reload_matrix_html("scalar_demo")

set_question_string_for_scalar_form = () ->
    document.getElementById("scalar_question_form_value").value = "\\["+ scalar + "*\\begin{bmatrix} " + matrix[0] + " & " + matrix[1] + " & " + matrix[2] + " \\\\ " + matrix[3] + " & " + matrix[4] + " & " + matrix[5] + " \\end{bmatrix}\\]"

set_answer_string_for_scalar_form = () ->
    document.getElementById("scalar_answer_form_value").value = "\\[\\begin{bmatrix} " + scaled_matrix[0] + " & "+scaled_matrix[1]+" & "+scaled_matrix[2]+" \\\\ "+scaled_matrix[3]+" & "+scaled_matrix[4]+" & "+scaled_matrix[5]+" \\end{bmatrix} \\]"

set_question_string_for_dot_product_form = () ->
    document.getElementById("dot_product_question_form_value").value =   "\\[" + return_real_matrix_html(dot_matrix_1) + "*" + return_real_matrix_html(dot_matrix_2) + "\\]"

set_answer_string_for_dot_product_form = () ->
    document.getElementById("dot_product_answer_form_value").value = "\\[" + return_real_matrix_html(matrix_multiplication(dot_matrix_1,dot_matrix_2)) + "\\]"

@return_scaled_matrix = () -> 
    scalar = generate_random(13)
    matrix = (generate_random(13) for num in matrix)
    return (scalar * num for num in matrix)

@solve_matrix_multiplication = () ->
    print_matrix_multiplication_html(matrix_multiplication(dot_matrix_1,dot_matrix_2))

@solve_matrix = (result_matrix) -> 
    set_question_string_for_scalar_form()
    scaled_matrix = result_matrix
    set_answer_string_for_scalar_form()
    html_first_part = "<p id=\"demo\">\\["
    html_second_part = "\\begin{bmatrix}"
    html_third_part = scaled_matrix[0] + " & " + scaled_matrix[1] + " & " + scaled_matrix[2] + "\\\\"+ scaled_matrix[3] + " & " + scaled_matrix[4] + " & " + scaled_matrix[5] + " \\end{bmatrix}\\]</p>"
    document.getElementById("scalar_demo").innerHTML =  html_first_part + return_matrix_html() + html_second_part + html_third_part
    MathJax.Hub.Queue(["Typeset",MathJax.Hub])

dot_product = (vector1, vector2) -> 
    return (num * vector2[index] for num, index in vector1).reduce (x,y) -> x + y

reorganize_matrix_for_easier_matrix_multiplication = (matrix1, matrix2) ->
    new_matrix = []
    for matrix_1_index in [0...matrix1.length] by 1
        vector = []
        for index in [0...matrix2.length] by 1
            vector.push(matrix2[index][matrix_1_index])
        new_matrix.push(vector)
    return new_matrix


matrix_multiplication = (matrix1, matrix2) ->
	return -1 if matrix1.length is not matrix2[0].length and matrix1[0].length is not matrix2.length
	matrix_2_dot_product_vectors = reorganize_matrix_for_easier_matrix_multiplication(matrix1,matrix2)
	result = []
	for matrix_1_index in [0...matrix1.length] by 1
		row = []
		for matrix_2_dot_product_vectors_index in [0...matrix_2_dot_product_vectors.length] by 1
			row.push(dot_product(matrix1[matrix_1_index],matrix_2_dot_product_vectors[matrix_2_dot_product_vectors_index]))
		result.push(row)
	return result
