*"* use this source file for your ABAP unit test classes
CLASS ltcl_fibonacci_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS:
      test_fibonacci_0 FOR TESTING,
      test_fibonacci_1 FOR TESTING,
      test_fibonacci_10 FOR TESTING,
      test_fibonacci_negative FOR TESTING.

ENDCLASS.

CLASS ltcl_fibonacci_test IMPLEMENTATION.

  METHOD test_fibonacci_0.
    DATA(cut) = NEW zcl_fibonacci( ).
    cl_abap_unit_assert=>assert_equals(
      act = cut->calc_element( 0 )
      exp = 0
      msg = 'Fibonacci(0) should be 0' ).
  ENDMETHOD.

  METHOD test_fibonacci_1.
    DATA(cut) = NEW zcl_fibonacci( ).
    cl_abap_unit_assert=>assert_equals(
      act = cut->calc_element( 1 )
      exp = 1
      msg = 'Fibonacci(1) should be 1' ).
  ENDMETHOD.

  METHOD test_fibonacci_10.
    DATA(cut) = NEW zcl_fibonacci( ).
    cl_abap_unit_assert=>assert_equals(
      act = cut->calc_element( 10 )
      exp = 89
      msg = 'Fibonacci(10) should be 89' ).
  ENDMETHOD.

  METHOD test_fibonacci_negative.
    DATA(cut) = NEW zcl_fibonacci( ).
    cl_abap_unit_assert=>assert_bound(
      act   = CAST cx_root( NEW cx_sy_range_out_of_bounds( ) )
      msg   = 'Expected exception for negative input' ).
    TRY.
        cut->calc_element( -1 ).
        cl_abap_unit_assert=>fail( 'Expected cx_sy_range_out_of_bounds for negative input' ).
      CATCH cx_sy_range_out_of_bounds.
        " Expected
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
