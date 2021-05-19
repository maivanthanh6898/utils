import sys

code_str = sys.argv[1]
print_count = 1000
if len(sys.argv) == 3:
    print_count = int(sys.argv[2])
first = 0
codes = code_str.split("|")
data = {}
total = len(codes) * 2
count = 0
for code in codes:
    data[code] = {
      "BID": 0,
      "QUOTE": 0,
    }

line_count = 0

for line in sys.stdin:
    if "print_status_cmd" in line or line_count % print_count == 0:
        print("----------------------------------------")
        for code in codes:
            print("{} : BID {}, QUOTE {}".format(code, data[code]["BID"], data[code]["QUOTE"]))
    line_count += 1
    if "print_line_cmd" in line:
        print("********" + line_count + ":" + line)
    if first < 10:
        sys.stdout.write(line)
        first += 1
    else:
        for code in codes:
            if ("stockCode=" + code) in line:
                if "BidOfferAutoItem" in line:
                    if data[code]["BID"] == 0:
                        count += 1
                        print(line)
                        print("{} found BID at line {}".format(code, line_count))
                    data[code]["BID"] += 1
                if "StockAutoItem" in line:
                    if data[code]["QUOTE"] == 0:
                        count += 1
                        print(line)
                        print("{} found QUOTE at line {}".format(code, line_count))
                    data[code]["QUOTE"] += 1
                if count == total:
                    print("Finish")
                    sys.exit(1)
                break


print("seem not founds")
for code in codes:
    print("{} : BID {}, QUOTE {}".format(code, data[code]["BID"], data[code]["QUOTE"]))
