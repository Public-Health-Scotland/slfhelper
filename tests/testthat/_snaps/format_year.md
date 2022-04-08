# Year check rejects clearly erronous years

    Invalid year:'twenty-twenty' was supplied.
    i Years should be supplied in the short financial year format e.g. '1718'

---

    Invalid year:'21' was supplied.
    i Years should be supplied in the short financial year format e.g. '1718'

# Year check rejects ambiguous years

    Ambiguous year:'2017' was supplied.
    i Years should be supplied in the short financial year format e.g. '1718'

---

    Ambiguous year:'2020' was supplied.
    i Years should be supplied in the short financial year format e.g. '1718'

---

    Ambiguous year:'1514' was supplied.
    i Years should be supplied in the short financial year format e.g. '1718'

# Year check rejects out of bounds years

    Invalid year:'1112' was supplied.
    i The oldest file available is 1213.

---

    Invalid year:'10/11' was supplied.
    i The oldest file available is 1213.

---

    Invalid year:'2011/12' was supplied.
    i The oldest file available is 1213.

