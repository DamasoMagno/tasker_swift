import SwiftUI

struct ContentView: View {
  @State var name: String = ""
  @State var tarefas: [String] = ["Primeira tarefa"]
  @State var currentTarefaId: String = ""
  @State var updateTaskModalIsOpen: Bool = false
  
  func handleInsertNewTask() {
    if !name.isEmpty {
      tarefas.append(name)
      name = ""
    }
  }
  
  func delete(tarefaName: String){
    tarefas.removeAll{
      tarefa in tarefa == tarefaName
    }
  }
  
  func setCurrentTarefaId(tarefa: String){
    currentTarefaId = tarefa
    updateTaskModalIsOpen = true
  }
  
  func updateTask(newText: String){
    if let index = tarefas.firstIndex(where: { $0 == currentTarefaId }) {
      tarefas[index] = newText
    }
    
    updateTaskModalIsOpen = false
    currentTarefaId = ""
  }
  
  var body: some View {
    VStack {
      Text("Tasker")
      HStack {
        TextField("Informe a tarefa", text: $name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {
          handleInsertNewTask()
        }){
          Image(systemName: "plus")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.black)
        }
      }
      
      ForEach(tarefas, id: \.self) { tarefa in
        
        updateTaskModalIsOpen ?
        HStack {
          Text(tarefa)
          Spacer()
          Button(action: {
            delete(tarefaName: tarefa)
          }) {
            Image(systemName:"trash")
              .foregroundColor(.black)
          }
        }.padding(.top, 25) :
        HStack {
          TextField("Informe a nova tarefa", text: $name)
          Spacer()
          Button(action: {
            delete(tarefaName: tarefa)
          }) {
            Image(systemName:"trash")
              .foregroundColor(.black)
          }
        }.padding(.top, 25)
        
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
