//
//  IntegranteInfo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegranteInfo: View {
    @EnvironmentObject var integrantesViewModel: IntegrantesViewModel
    @State var isShowingSheet = false
    @ObservedObject var integranteViewModel = IntegranteViewModel()
    var id: String
    
    func getEdad () -> Int {
        let cal = Calendar(identifier: .gregorian)
        guard let years = cal.dateComponents(
            [.year],
            from: integranteViewModel.integrante.fechaNacimiento,
            to: Date()
        ).year else {
            return 0
        }
        return years
    }
    
    func getEtapaDeberia() -> Etapa? {
        let edad = getEdad()
        guard let etapaDeberia = etapaEdad[edad] else {
            return nil
        }
        
        return etapaDeberia
    }
    
    func isEtapaRight() -> Bool {
        return getEtapaDeberia() == integranteViewModel.integrante.etapa
    }
    
    func handleEdit() {
        isShowingSheet = true
        integrantesViewModel.integranteNuevo = integranteViewModel.integrante
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(integranteViewModel.integrante.nombre)
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }.padding()
                .background(.gray)
            ScrollView {
                
                Group {
                    InfoRow(label: "Nombre de Caza", value: integranteViewModel.integrante.nombreCaza ?? "")
                    InfoBoolRow(label: "Carnetizado", value: integranteViewModel.integrante.carnetizado)
                    InfoBoolRow(label: "Promesa", value: integranteViewModel.integrante.promesa)
                    InfoRow(label: "Fecha Nacimiento", value: integranteViewModel.integrante.fechaNacimiento.formatted(date: .abbreviated, time: .omitted))
                    InfoRow(label: "Edad", value: "\(getEdad()) años")
                }
                
                HStack {
                    Text("Contacto Emergencia")
                        .foregroundColor(.gray)
                    Spacer()
                    Link(integranteViewModel.integrante.contactoEmergencia.nombre, destination: URL(string: "tel:\(integranteViewModel.integrante.contactoEmergencia.numero)") ?? URL(string: "tel:911")!)
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                DividerAdjusted()
                
                HStack {
                    Text("Seisena")
                        .foregroundColor(.gray)
                    Spacer()
                    InfoSeisena(seisena: integranteViewModel.integrante.seisena)
                }.padding(.horizontal)
                    .padding(.top)
                
                DividerAdjusted()
                
                Group {
                    HStack {
                        Text("Etapa")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(integranteViewModel.integrante.etapa.rawValue)")
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    
                    HStack(alignment: .center) {
                        Image(integranteViewModel.integrante.etapa.rawValue)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(10)
                            .border(isEtapaRight() ? .green : .red, width: 2)
                        
                    }.frame(maxWidth: .infinity)
                    
                    if !isEtapaRight() {
                        if let nuevaEtapa = getEtapaDeberia() {
                            Text("Cambiar a: \(nuevaEtapa.rawValue)")
                                .bold()
                        }
                    }
                    DividerAdjusted()
                }
                
                Group {
                    ForEach(TodasLasEspecialidades.indices, id: \.self) { i in
                        EspecialidadView(integrante: integranteViewModel.integrante, especialidad: TodasLasEspecialidades[i])
                    }
                }
                
                Spacer()
                
                Button(action: handleEdit) {
                    Text("Editar")
                }.buttonStyle(.bordered)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
                IntegranteNuevo(nombreCaza: integranteViewModel.integrante.nombreCaza ?? "", handleClose: handleCloseSheet)
            }
            .onAppear {
                integranteViewModel.subscribe(id: id)
            }
            .onDisappear {
                integranteViewModel.unsubscribe()
            }
        }
    }
}

struct IntegranteInfo_Previews: PreviewProvider {
    static let especialidades = Especialidades()
    static let contactoEmergencia = ContactoEmergencia(nombre: "Juanita Perez", numero: "0987607014")
    static var previews: some View {
        IntegranteInfo(id: "123")
    }
}
