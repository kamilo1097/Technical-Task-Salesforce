import { LightningElement, track } from 'lwc';
import sortArrayFromApex from '@salesforce/apex/StringArrayLengthSort.sortArrayBasedOnLength';

export default class StringArrayLengthSort extends LightningElement {
    sourceText = "Wlazł kotek na płotek i mruga, ładna to piosenka, nie długa. Nie długa, nie krótka, lecz w sam raz, zaśpiewaj koteczku, jeszcze raz"

    pattern = /[.,]/g;

    @track outputArrayLWC = [];
    @track outputArrayApex = [];


    connectedCallback(){
        this.outputArrayLWC = this.sortArrayLWC(this.sourceText.split(" "));
       sortArrayFromApex({sourceText: this.sourceText}).then(result=>{
        this.outputArrayApex = result;
       });
    }

    sortArrayLWC(arr){
        let clearArray = arr.map(word => word.replace(this.pattern, ''));
        return clearArray.slice().sort((a, b) => a.length - b.length);
    }

}