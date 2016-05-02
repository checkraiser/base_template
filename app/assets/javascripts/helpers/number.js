function get_random_whole_number_between(min, max) {
    var range = (max - min) + 1
    return Math.floor(Math.random() * range) + min
}

Number.prototype.toRoman= function () {
    var num = Math.floor(this),
        val, s= '', i= 0,
        v = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1],
        r = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];

    function toBigRoman(n) {
        var ret = '', n1 = '', rem = n;
        while (rem > 1000) {
            var prefix = '', suffix = '', n = rem, s = '' + rem, magnitude = 1;
            while (n > 1000) {
                n /= 1000;
                magnitude *= 1000;
                prefix += '(';
                suffix += ')';
            }
            n1 = Math.floor(n);
            rem = s - (n1 * magnitude);
            ret += prefix + n1.toRoman() + suffix;
        }
        return ret + rem.toRoman();
    }

    if (this - num || num < 1) num = 0;
    if (num > 3999) return toBigRoman(num);

    while (num) {
        val = v[i];
        while (num >= val) {
            num -= val;
            s += r[i];
        }
        ++i;
    }
    return s;
};