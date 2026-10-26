CLASS zcl_fibonacci DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS class_constructor .
    METHODS calc_element
    IMPORTING
      !n TYPE i
    RETURNING
      VALUE(result) TYPE int8
    RAISING
      cx_sy_range_out_of_bounds .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS c_max_n TYPE i VALUE 50.
ENDCLASS.



CLASS zcl_fibonacci IMPLEMENTATION.


  METHOD class_constructor.
    " Class initialization if needed
  ENDMETHOD.


  METHOD calc_element.
    DATA fib_prev TYPE int8 VALUE 0.
    DATA fib_curr TYPE int8 VALUE 1.
    DATA fib_next TYPE int8.

    " Input validation
    IF n < 0 OR n > c_max_n.
      RAISE EXCEPTION TYPE cx_sy_range_out_of_bounds.
    ENDIF.

    " Handle base cases
    CASE n.
      WHEN 0.
        result = 0.
        RETURN.
      WHEN 1.
        result = 1.
        RETURN.
    ENDCASE.

    " Calculate fibonacci for n >= 2
    DO n - 1 TIMES.
      fib_next = fib_prev + fib_curr.
      fib_prev = fib_curr.
      fib_curr = fib_next.
    ENDDO.

    result = fib_curr.
  ENDMETHOD.
ENDCLASS.
