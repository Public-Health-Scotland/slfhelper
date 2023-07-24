# Year check rejects clearly erronous years

    The year "twenty-twenty" is not valid.
    i Values to `year` should be supplied in the short financial year format e.g. "1718"

---

    The year 21 is not valid.
    i Values to `year` should be supplied in the short financial year format e.g. "1718"

# Year check rejects ambiguous years

    The year "2017" is ambiguous.
    i Values to `year` should be supplied in the short financial year format e.g. "1718"
    v Did you mean "2021" or "1617"?

---

    The year "2020" is ambiguous.
    i Values to `year` should be supplied in the short financial year format e.g. "1718"
    v Did you mean "2021" or "1920"?

---

    The year "1514" is ambiguous.
    i Values to `year` should be supplied in the short financial year format e.g. "1718"
    v Did you mean "1516" or "1314"?

# Year check rejects out of bounds years

    The year "1011" is not valid.
    i The oldest valid `year` is "1112".

---

    The year "10/11" is not valid.
    i The oldest valid `year` is "1112".

---

    The year "2010/11" is not valid.
    i The oldest valid `year` is "1112".

