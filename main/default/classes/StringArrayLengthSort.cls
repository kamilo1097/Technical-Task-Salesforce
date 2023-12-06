public with sharing class StringArrayLengthSort {

    @AuraEnabled
    public static List<String> sortArrayBasedOnLength(String sourceText){
        String pattern = '[.,]';
        List<String> arrayOfWords = sourceText.split(' ');

        List<String> clearArray = new List<String>();
        for (String word : arrayOfWords) {
            String clearWord = word.replaceAll(pattern, '');
            clearArray.add(clearWord);
        }

        List<StringComparable> comparables = new List<StringComparable>();
        for(String word : clearArray) {
            comparables.add(new StringComparable(word));
        }

        comparables.sort();

        List<String> sortedList = new List<String>();
        for(StringComparable comp : comparables) {
            sortedList.add(comp.word);
        }
        return sortedList;
    }

    public class StringComparable implements Comparable {
        public String word;

        public StringComparable(String word) {
            this.word = word;
        }

        public Integer compareTo(Object obj){
            if(obj instanceof StringComparable){
                StringComparable other = (StringComparable)obj;
                return this.word.length() - other.word.length();
            } else {
                throw new IllegalArgumentException('Object must be of type StringComparable');
            }
        }
    }
}