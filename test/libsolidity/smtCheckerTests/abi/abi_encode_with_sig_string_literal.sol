contract C {
	function abiEncodeStringLiteral(string memory sig) public pure {
		bytes memory b1 = abi.encodeWithSignature(sig, "");
		bytes memory b2 = abi.encodeWithSignature(sig, "");
		// should hold, but currently fails due to string literal abstraction
		assert(b1.length == b2.length);

		bytes memory b3 = abi.encodeWithSignature(sig, bytes(""));
		assert(b1.length == b3.length); // should fail

		bytes memory b4 = abi.encodeWithSignature(sig, bytes24(""));
		// should hold, but currently fails due to string literal abstraction
		assert(b1.length == b4.length);

		bytes memory b5 = abi.encodeWithSignature(sig, string(""));
		assert(b1.length == b5.length); // should fail

		bytes memory b6 = abi.encodeWithSelector("f()", bytes24(""));
		assert(b4.length == b6.length); // should fail
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (261-291): CHC: Assertion violation happens here.
// Warning 1218: (357-387): CHC: Error trying to invoke SMT solver.
// Warning 1218: (542-572): CHC: Error trying to invoke SMT solver.
// Warning 1218: (639-669): CHC: Error trying to invoke SMT solver.
// Warning 1218: (753-783): CHC: Error trying to invoke SMT solver.
// Warning 5840: CHC: 4 verification condition(s) could not be proved. Enable the model checker option "show unproved" to see all of them. Consider choosing a specific contract to be verified in order to reduce the solving problems. Consider increasing the timeout per query.
// Warning 4661: (357-387): BMC: Assertion violation happens here.
// Warning 4661: (542-572): BMC: Assertion violation happens here.
// Warning 4661: (639-669): BMC: Assertion violation happens here.
// Warning 4661: (753-783): BMC: Assertion violation happens here.
